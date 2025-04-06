#include <iostream>

class TerminalStream {
public:
  TerminalStream();
  TerminalStream(TerminalStream &&) = default;
  TerminalStream(const TerminalStream &) = default;
  TerminalStream &operator=(TerminalStream &&) = default;
  TerminalStream &operator=(const TerminalStream &) = default;
  ~TerminalStream();
};

TerminalStream::TerminalStream() {
  std::cout << "Terminal stream created." << std::endl;
}

TerminalStream::~TerminalStream() {
  std::cout << "Terminal stream destructed." << std::endl;
}

int main(int argc, char *argv[]) {
  TerminalStream termStream;
  return 0;
}
