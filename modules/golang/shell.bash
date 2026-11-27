export GOPATH="$HOME/.local/share/go"

case ":$PATH:" in
  *":$GOPATH/bin:"*) ;;
  *) export PATH="$PATH:$GOPATH/bin" ;;
esac
