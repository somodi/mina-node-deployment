 with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "mina-mainnet";
  version = "1.3.1beta1-master-3e3abec";

  src = fetchurl {
    url = "https://packages.o1test.net/pool/focal/m/mi/mina-mainnet_${version}.deb";
    sha256 = "sha256-48aaf396971ff40475b91a498dbf0c34776cd1679b62fdb126dd9208e6cab025";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
  ];

  sourceRoot = ".";

  installPhase = ''
    sha256sum mina-mainnet_${version}.deb
  '';

  meta = with lib; {
    homepage = "";
    description = "Mina mainnet";
    platforms = platforms.linux;
  };
}