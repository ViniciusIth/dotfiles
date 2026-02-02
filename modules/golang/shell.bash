export GOROOT="/usr/local/go"

export GOPATH="$HOME/go"

case ":$PATH:" in
  *":$GOROOT/bin:"*) ;;
  *) export PATH="$GOROOT/bin:$PATH" ;;
esac

case ":$PATH:" in
  *":$GOPATH/bin:"*) ;;
  *) export PATH="$PATH:$GOPATH/bin" ;;
esac
