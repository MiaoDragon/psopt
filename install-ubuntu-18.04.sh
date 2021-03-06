# Script for installing PSOPT on Ubuntu 18.04
# Install miscellaneous libraries
export MYHOME=`pwd`
echo $MYHOME
sudo apt-get install build-essential pkg-config
sudo apt-get install dh-autoreconf
sudo apt-get -y install g++ gfortran f2c libf2c2-dev libf2c2 libblas-dev libopenblas-base libopenblas-dev libblas3 libatlas-base-dev liblapack-dev liblapack3
# Download and install Ipopt, Metis and Mumps
cd $HOME/Downloads
wget --continue http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.12.tgz
cd $HOME
tar xzvf ./Downloads/Ipopt-3.12.12.tgz
cd $HOME/Ipopt-3.12.12/ThirdParty/Metis
./get.Metis
cd $HOME/Ipopt-3.12.12/ThirdParty/Mumps
./get.Mumps
cd $HOME/Ipopt-3.12.12
./configure --enable-static coin_skip_warn_cxxflags=yes
make -j
make install
# Download and install ADOLC and ColPack
cd $HOME/Downloads
wget --continue www.coin-or.org/download/source/ADOL-C/ADOL-C-2.6.3.tgz
cd $HOME
tar zxvf ./Downloads/ADOL-C-2.6.3.tgz
cd $HOME/ADOL-C-2.6.3
mkdir ./ThirdParty
cd ./ThirdParty

wget --continue http://archive.ubuntu.com/ubuntu/pool/universe/c/colpack/colpack_1.0.10.orig.tar.gz

tar zxvf colpack_1.0.10.orig.tar.gz

mv ColPack-1.0.10 ColPack
cd ColPack
./autoconf.sh
make
sudo make install
# sudo cp /usr/local/lib/libCol* /usr/lib
sudo cp -P ./build/lib/libCol* /usr/lib
cd $HOME/ADOL-C-2.6.3
./configure --enable-sparse --with-colpack=$HOME/ADOL-C-2.6.3/ThirdParty/ColPack/build
make
make install
sudo cp -P $HOME/adolc_base/lib64/lib* /usr/lib
sudo cp -r $HOME/adolc_base/include/* /usr/include/
# Download and install PDFlib
cd $HOME/Downloads
wget --continue https://fossies.org/linux/misc/old/PDFlib-Lite-7.0.5p3.tar.gz
tar zxvf PDFlib-Lite-7.0.5p3.tar.gz
cd PDFlib-Lite-7.0.5p3 
./configure
make; sudo make install
sudo ldconfig
# Download and install GNUplot
cd $HOME/Downloads
wget --continue https://sourceforge.net/projects/gnuplot/files/gnuplot/4.4.0/gnuplot-4.4.0.tar.gz/download
mv download gnuplot-4.4.0.tar.gz
tar zxvf gnuplot-4.4.0.tar.gz
# sudo apt-get -y install libx11-dev libxt-dev libgd2-xpm-dev libreadline6-dev
sudo apt-get -y install libx11-dev libxt-dev libreadline6-dev libgd-dev
cd gnuplot-4.4.0
./configure -with-readline=gnu -without-tutorial
make;sudo make install
# Download and extract PSOPT
# cd $HOME
# wget --continue https://github.com/PSOPT/psopt/archive/master.zip
# unzip master.zip
# mv master.zip $HOME/Downloads
cd $MYHOME
# Download and extract SuiteSparse
wget --continue http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.4.3.tar.gz
tar zxvf SuiteSparse-4.4.3.tar.gz
cd $MYHOME
# Download and extract LUSOL
wget --continue http://www.stanford.edu/group/SOL/software/lusol/lusol.zip
unzip lusol.zip
cd $MYHOME
# Compile SuiteSparse, LUSOL, dmatrix and PSOPT
make all
echo 'PSOPT installation script completed'
echo 'PSOPT installed in $MYHOME'

