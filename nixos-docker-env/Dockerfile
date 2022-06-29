FROM nixos/nix

COPY ./mina-mainnet_1.3.1beta1-master-3e3abec.deb ./

RUN nix-env -iA nixpkgs.ocamlPackages.core

COPY ./default.nix ./
COPY ./derivation.nix ./
RUN nix-build --show-trace

# CMD ["sleep", "10"]
# ENTRYPOINT ["bash"]
CMD ["/bin/sh"]