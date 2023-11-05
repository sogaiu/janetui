(declare-project
  :name "janetui"
  :desc "janet bindings for the simple & portable GUI library libui: https://github.com/andlabs/libui"
  :url "https://github.com/janet-lang/janetui"
  :repo "https://github.com/janet-lang/janetui.git")

(defn pkg-config
  [& args]
  (def output
    (with [of (file/temp)]
      (try
        (do
          (os/execute ["pkg-config" ;args] :px {:out of})
          (file/flush of)
          (file/seek of :set 0)
          (file/read of :all))
        ([e]
          (eprint e)
          nil))))
  (when output
    (->> (string/trimr output)
         (string/split " "))))

(def o (os/which))

(def cflags
  (case o
    # XXX:
    #:macos
    #["-Ilibui"]
    #:windows
    #["-Ilibui"]
    :linux
    ["-Ilibui"
     ;(filter |(string/has-prefix? "-I" $)
              (pkg-config "--cflags" "gtk+-3.0"))]))

(def lflags
  (case o
    # XXX:
    #:windows
    #["user32.lib" "gdi32.lib" "winmm.lib" "shell32.lib"]
    #:macos
    #["-lpthread" "-framework" "Cocoa" "-framework" "CoreVideo" "-framework" "IOKit" "-framework" "OpenGL"]
    :linux
    ["-lpthread" "-lX11"
     ;(pkg-config "--libs" "gtk+-3.0")]))

(def unix-c-files
  (seq [name :in (os/dir "libui/unix")
        :when (and (string/has-suffix? ".c" name)
                   (not (string/has-prefix? "OLD_" name)))]
    (string "libui/unix/" name)))

(def unix-h-files
  (seq [name :in (os/dir "libui/unix")
        :when (and (string/has-suffix? ".h" name)
                   (not (string/has-prefix? "OLD_" name)))]
    (string "libui/unix/" name)))

(declare-native
  :name "janetui"

  :cflags [;default-cflags ;cflags]

  :source ["main.c"
           # libui sources
           #"libui/common/OLD_table.c"
           "libui/common/matrix.c"
           "libui/common/areaevents.c"
           "libui/common/opentype.c"
           "libui/common/attribute.c"
           "libui/common/shouldquit.c"
           "libui/common/attrlist.c"
           "libui/common/tablemodel.c"
           "libui/common/attrstr.c"
           "libui/common/tablevalue.c"
           "libui/common/control.c"
           "libui/common/userbugs.c"
           "libui/common/debug.c"
           "libui/common/utf.c"
           ;(case o
             :linux
              unix-c-files)]

  :headers ["libui/ui.h"
            "libui/common/attrstr.h"
            "libui/common/table.h"
            "libui/common/utf.h"
            "libui/common/controlsigs.h"
            "libui/common/uipriv.h"
            ;(case o
               :linux
               ["libui/ui_unix.h" ;unix-h-files])]

  :lflags [;default-lflags ;lflags])

