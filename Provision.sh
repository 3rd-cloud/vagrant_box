echo Vagrant Box Provisioning...
dnf -y update

echo Vagrant Box Finalize...
dnf clean all
shutdown -h now