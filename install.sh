if [ -f "/usr/local/bin/brew" ]
then
echo ""
else
echo "Installing brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
echo "Installing dependencies.."
brew install libimobiledevice
brew install ideviceinstaller
echo "Fixing stuff..."
cd /usr/local/opt/openssl/lib/
mkdir /opt
mkdir /opt/local
mkdir /opt/local/lib
cp libcrypto*dylib /opt/local/lib/

echo "Downloading latest futurerestore..."
mkdir ~/.futurerestore
curl -o ~/.futurerestore/futurerestore.zip http://api.tihmstar.net/builds/futurerestore/futurerestore-latest.zip
cd ~/.futurerestore
unzip futurerestore.zip
chmod 775 futurerestore_macos
mv futurerestore_macos /usr/local/bin/futurerestore
echo "Cleaning up..."
cd ..
rm -rf .futurerestore
echo "Done"

