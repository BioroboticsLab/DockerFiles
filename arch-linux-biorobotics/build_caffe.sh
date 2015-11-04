git clone https://github.com/BVLC/caffe.git /opt/caffe
# commit from Sep 9. 2015
git checkout 4f8775c1e88604879edef0698acab7b0d8a2ab43
mkdir -pv /opt/caffe/build
cd /opt/caffe/build
cmake -DCMAKE_CXX_COMPILER=/usr/bin/c++ -DBLAS=open -DUSE_CUDNN=1 -DCMAKE_BUILD_TYPE=Release ..
make all -j `nprog`
make install
