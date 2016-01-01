# Maintainer: Colin Woodbury <colingw@gmail.com>
_hkgname=aura
pkgname=aura-bin32
pkgver=1.3.4
pkgrel=1
pkgdesc="A secure package manager for Arch Linux and the AUR written in Haskell - Prebuilt binary"
url="https://github.com/fosskers/aura"
2license=('GPL-3')
arch=('i686')
depends=('gmp' 'pacman' 'pcre' 'abs')
optdepends=('powerpill:    For faster repository downloads.'
            'customizepkg: For auto-editing of PKGBUILDs.'
            'aur-git:      AUR package completions for zsh.')
provides=('aura')
conflicts=('aura' 'aura-git' 'aura-bin')
options=('strip')
source=(${_hkgname}-${pkgver}-${CARCH}.tar.gz)
md5sums=('c60dff0598903c98814a22b4dfa8b930')

package() {
    # Install aura binary
    mkdir -p "$pkgdir/usr/bin/"
    install -m 755 aura "$pkgdir/usr/bin/"
  
    # Installing man page
    mkdir -p "$pkgdir/usr/share/man/man8/"
    install -m 644 aura.8 "$pkgdir/usr/share/man/man8/aura.8"

    # Installing bash completions
    mkdir -p "$pkgdir/usr/share/bash-completion/completions/"
    install -m 644 bashcompletion.sh "$pkgdir/usr/share/bash-completion/completions/aura"

    # Installing zsh completions
    mkdir -p "$pkgdir/usr/share/zsh/site-functions/"
    install -m 644 _aura "$pkgdir/usr/share/zsh/site-functions/_aura"

    # Directory for storing PKGBUILDs
    mkdir -p "$pkgdir/var/cache/aura/pkgbuilds"

    # Directory for storing source packages
    mkdir -p "$pkgdir/var/cache/aura/src"

    # Directory for storing installed package states
    mkdir -p "$pkgdir/var/cache/aura/states"
}
