class Q3270 < Formula
  desc "Qt-based 3270 Terminal Emulator"
  homepage "https://github.com/hobbithacker/Q3270"
  url "https://github.com/HobbitHacker/Q3270/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "1655303c7b30e42379a460792dde4b682f1568ff6fe30af704a049b1fcd2dea7"
  depends_on "cmake" => :build
  depends_on "qt@6"

  def install
    qt6 = Formula["qt@6"].opt_prefix

    arch = Hardware::CPU.arm? ? "arm64" : "x86_64"

    mkdir "build" do
      system "cmake", "..", *std_cmake_args,
             "-DCMAKE_PREFIX_PATH=#{qt6}",
             "-DCMAKE_OSX_ARCHITECTURES=#{arch}"
      system "make", "-j#{ENV.make_jobs}"

      prefix.install "src/Q3270.app"
    end
  end

  def caveats
    <<~EOS
      Q3270.app has been installed to:
        #{opt_prefix}/Q3270.app
      To link it to your Applications folder, run:
        ln -s #{opt_prefix}/Q3270.app /Applications/
    EOS
  end
end
