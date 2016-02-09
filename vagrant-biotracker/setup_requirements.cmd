@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

choco install -y git
choco install -y python2
choco install -y cmake

choco install -y vcredist2012
choco install -y qt-sdk-windows-x64-msvc2012
choco install -y opencv
choco install -y boost-msvc-12
