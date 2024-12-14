# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class SunxiTools < Formula
  desc ""
  homepage "https://linux-sunxi.org/Sunxi-tools"
  url "https://github.com/linux-sunxi/sunxi-tools.git", branch: "master", revision: "29d48c3c39d74200fb35b5750f99d06a4886bf2e"
  version "master"
  license "GPL-2.0"

  depends_on "dtc" => :build
  depends_on "libusb" => :build
  depends_on "coreutils" => :build

  patch :DATA

  def install
    # Remove unrecognized options if they cause configure to fail
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    #system "./configure", "--disable-silent-rules", *std_configure_args
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "make", "PREFIX=#{prefix}", "INSTALL=ginstall", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test sunxi-tools`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end

__END__
diff --git a/Makefile b/Makefile
index 3d89718..d8bd20a 100644
--- a/Makefile
+++ b/Makefile
@@ -65,6 +65,7 @@ DESTDIR ?=
 PREFIX  ?= /usr/local
 BINDIR  ?= $(PREFIX)/bin
 MANDIR  ?= $(PREFIX)/share/man/man1
+INSTALL ?= install
 
 .PHONY: all clean tools target-tools install install-tools install-target-tools
 .PHONY: check
@@ -84,23 +85,23 @@ install-all: install-tools install-target-tools
 install-tools: $(TOOLS)
 	install -d $(DESTDIR)$(BINDIR)
 	@set -ex ; for t in $^ ; do \
-		install -m0755 $$t $(DESTDIR)$(BINDIR)/$$t ; \
+		$(INSTALL) -m0755 $$t $(DESTDIR)$(BINDIR)/$$t ; \
 	done
 	@set -ex ; for l in $(FEXC_LINKS) ; do \
 		ln -nfs sunxi-fexc $(DESTDIR)$(BINDIR)/$$l ; \
 	done
-	install -D -m0644 -t $(DESTDIR)$(MANDIR) sunxi-fel.1
+	$(INSTALL) -D -m0644 -t $(DESTDIR)$(MANDIR) sunxi-fel.1
 
 install-target-tools: $(TARGET_TOOLS)
-	install -d $(DESTDIR)$(BINDIR)
+	$(INSTALL) -d $(DESTDIR)$(BINDIR)
 	@set -ex ; for t in $^ ; do \
-		install -m0755 $$t $(DESTDIR)$(BINDIR)/$$t ; \
+		$(INSTALL) -m0755 $$t $(DESTDIR)$(BINDIR)/$$t ; \
 	done
 
 install-misc: $(MISC_TOOLS)
-	install -d $(DESTDIR)$(BINDIR)
+	$(INSTALL) -d $(DESTDIR)$(BINDIR)
 	@set -ex ; for t in $^ ; do \
-		install -m0755 $$t $(DESTDIR)$(BINDIR)/$$t ; \
+		$(INSTALL) -m0755 $$t $(DESTDIR)$(BINDIR)/$$t ; \
 	done
 
 
