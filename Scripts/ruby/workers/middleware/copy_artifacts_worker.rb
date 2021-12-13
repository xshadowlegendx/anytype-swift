require_relative '../../constants'

class CopyLibraryArtifactsFromTemporaryDirectoryToTargetDirectoryWorker
  attr_accessor :temporaryDirectoryPath, :targetDirectoryPath

  def initialize(temporaryDirectoryPath, targetDirectoryPath)
    self.temporaryDirectoryPath = temporaryDirectoryPath
    self.targetDirectoryPath = targetDirectoryPath
  end

  def work
    middlewareLibraryName = "Lib.xcframework"
    filenames = [middlewareLibraryName, Constants::PROTOBUF_DIRECTORY_NAME]

    files = filenames.map { |x| File.join(temporaryDirectoryPath, x) }
    FileUtils.mv(files, targetDirectoryPath)
  end
end