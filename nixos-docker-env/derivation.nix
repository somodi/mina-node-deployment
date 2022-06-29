{ stdenv, dpkg, glibc, gcc-unwrapped, autoPatchelfHook, openssl, zlib, libffi, gmp, bzip2, jemalloc, postgresql_12 }:
let

  version = "1.3.1beta1-master-3e3abec";

  src = ./mina-mainnet_1.3.1beta1-master-3e3abec.deb;

  # https://gist.github.com/pniedzwiedzinski/f67be56db8756cfdb57e31a2b02d896a
  
  bzip2_linked = stdenv.mkDerivation {
    name = "bzip2-linked";
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/lib
      cp -r ${bzip2.out}/lib/libbz2.so.1.0.6 $out/lib
      ln -s $out/lib/libbz2.so.1.0.6 $out/lib/libbz2.so.1.0
    '';
  };



in stdenv.mkDerivation {
  name = "mina-mainnet-${version}";

  system = "x86_64-linux";

  inherit src;

  

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
  ];

  # Required at running time
  buildInputs = [
    glibc
    gcc-unwrapped
    openssl
    zlib
    libffi
    gmp
    bzip2
    jemalloc
    postgresql_12
    
    bzip2_linked
  ];

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    #cp -av $out/opt/Wolfram/WolframScript/* $out
    rm -rf $out/opt
  '';

  meta = with stdenv.lib; {
    homepage = "";
    description = "Mina mainnet";
    platforms = platforms.linux;
  };
}