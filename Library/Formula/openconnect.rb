require 'formula'

class VpncScript < Formula
  url 'http://git.infradead.org/users/dwmw2/vpnc-scripts.git/blob_plain/HEAD:/vpnc-script'
  md5 '7a51184f883bba826615e85853e6d30a'
end

class Openconnect < Formula
  homepage 'http://www.infradead.org/openconnect.html'
  url 'ftp://ftp.infradead.org/pub/openconnect/openconnect-4.06.tar.gz'
  sha1 'f51321920310d2e582fc246dcc77c43f9e01cc71'

  depends_on 'pkg-config' => :build
  depends_on 'gettext'

  def install
    VpncScript.new.brew { etc.install Dir['*'] }
    chmod 0755, "#{etc}/vpnc-script"

    args = %W[
      --prefix=#{prefix}
      --sbindir=#{bin}
      --localstatedir=#{var}
      --with-vpnc-script=#{etc}/vpnc-script
    ]

    system "./configure", *args
    system "make install"
  end

  def caveats; <<-EOS.undent
    OpenConnect requires the use of a TUN/TAP driver.

    You can download one at http://tuntaposx.sourceforge.net/
    and install it prior to running OpenConnect.
    EOS
  end
end
