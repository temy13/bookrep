sudo yum -y groupinstall "Development tools"
sudo yum -y install gcc zlib-devel bzip2-devel openssl-devel readline-devel ncurses-devel sqlite-devel gdbm-devel db4-devel expat-devel libpcap-devel xz-devel pcre-devel
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
exec $SHELL
source ~/.bash_profile
pyenv install 3.5.0
pyenv rehash
pyenv global 3.5.0
python -V
pip install --upgrade pip
pip install requests
