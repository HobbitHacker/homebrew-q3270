class Q3270 < Formula
  desc "Qt-based 3270 Terminal Emulator"
  homepage "https://github.com/hobbithacker/Q3270"
  # You will update this URL and SHA whenever you release a new version
  url "https://github.com/hobbithacker/Q3270/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "f9f2eeae6a6e8874493eb6bb0c3c5cc04037cdcc7c8b706e742ac138cc3ef1ef"

  depends_on "cmake" => :build
  depends_on "qt@5"

  def install
    # Homebrew versions of Qt5 are 'keg-only', so we must point CMake to them
    qt5 = Formula["qt@5"].opt_prefix
    
    # Detect if we are on Intel or ARM
    arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    
    mkdir "build" do
      system "cmake", "..", *std_cmake_args,
             "-DCMAKE_PREFIX_PATH=#{qt5}",
             "-DCMAKE_OSX_ARCHITECTURES=#{arch}" # <--- Use the detected arch
      system "make", "-j#{ENV.make_jobs}"
      
      # Install the bundle into the Homebrew prefix
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
