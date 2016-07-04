#include "../Current/current.h"

#include "../Current/Bricks/waitable_atomic/waitable_atomic.h"

DEFINE_uint16(port, 3000, "The port to run on.");

int main(int argc, char** argv) {
  ParseDFlags(&argc, &argv);

  current::WaitableAtomic<bool> done(false);

  HTTP(FLAGS_port).Register("/", [](Request r) {
    r("Hello, Buddy! Sup?\n");
  });

  HTTP(FLAGS_port).Register("/shutdown", [&done](Request r) {
    done.SetValue(true);
    r("OK\n");
  });

  done.Wait([](bool b) { return b; });
}
