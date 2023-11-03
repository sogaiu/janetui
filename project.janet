(declare-project
  :name "janetui"
  :desc "janet bindings for the simple & portable GUI library libui: https://github.com/andlabs/libui"
  :url "https://github.com/janet-lang/janetui"
  :repo "https://github.com/janet-lang/janetui.git")

(def o (os/which))

(def cflags
  (case o
    # XXX:
    #:macos '["-Ilibui"]
    #:windows ["-Ilibui"]
    '["-Ilibui"
      "-I/usr/include/gtk-3.0"
      "-I/usr/include/glib-2.0"
      "-I/usr/include/pango-1.0"
      "-I/usr/include/harfbuzz"
      "-I/usr/include/cairo"
      "-I/usr/include/gdk-pixbuf-2.0"
      "-I/usr/include/atk-1.0"
      "-I/usr/lib/glib-2.0/include"]))

(def lflags
  (case o
    # XXX:
    #:windows '["user32.lib" "gdi32.lib" "winmm.lib" "shell32.lib"]
    #:macos '["-lpthread" "-framework" "Cocoa" "-framework" "CoreVideo" "-framework" "IOKit" "-framework" "OpenGL"]
    '["-lpthread" "-lX11"
      "-lgtk-3"
      "-lgdk-3"
      "-lz"
      "-lpangocairo-1.0"
      "-lpango-1.0"
      "-lharfbuzz"
      "-latk-1.0"
      "-lcairo-gobject"
      "-lcairo"
      "-lgdk_pixbuf-2.0"
      "-lgio-2.0"
      "-lgobject-2.0"
      "-lglib-2.0"]))

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
           #"libui/unix/OLD_table.c"
           "libui/unix/future.c"
           "libui/unix/alloc.c"
           "libui/unix/graphemes.c"
           "libui/unix/area.c"
           "libui/unix/grid.c"
           "libui/unix/attrstr.c"
           "libui/unix/group.c"
           "libui/unix/box.c"
           "libui/unix/image.c"
           "libui/unix/button.c"
           "libui/unix/label.c"
           "libui/unix/cellrendererbutton.c"
           "libui/unix/main.c"
           "libui/unix/checkbox.c"
           "libui/unix/menu.c"
           "libui/unix/child.c"
           "libui/unix/multilineentry.c"
           "libui/unix/colorbutton.c"
           "libui/unix/opentype.c"
           "libui/unix/combobox.c"
           "libui/unix/progressbar.c"
           "libui/unix/control.c"
           "libui/unix/radiobuttons.c"
           "libui/unix/datetimepicker.c"
           "libui/unix/separator.c"
           "libui/unix/debug.c"
           "libui/unix/slider.c"
           "libui/unix/draw.c"
           "libui/unix/spinbox.c"
           "libui/unix/drawmatrix.c"
           "libui/unix/stddialogs.c"
           "libui/unix/drawpath.c"
           "libui/unix/tab.c"
           "libui/unix/drawtext.c"
           "libui/unix/table.c"
           "libui/unix/editablecombo.c"
           "libui/unix/tablemodel.c"
           "libui/unix/entry.c"
           "libui/unix/text.c"
           "libui/unix/fontbutton.c"
           "libui/unix/util.c"
           "libui/unix/fontmatch.c"
           "libui/unix/window.c"
           "libui/unix/form.c"]

  :headers ["libui/ui.h"
            "libui/ui_unix.h"
            #"libui/OLD_uitable.h"
            "libui/common/attrstr.h"
            "libui/common/table.h"
            "libui/common/utf.h"
            "libui/common/controlsigs.h"
            "libui/common/uipriv.h"
            "libui/unix/attrstr.h"
            "libui/unix/table.h"
            "libui/unix/draw.h"
            "libui/unix/uipriv_unix.h"]

  :lflags [;default-lflags ;lflags])

