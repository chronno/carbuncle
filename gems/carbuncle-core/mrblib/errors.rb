# This module contains all Carbuncle's game engine related classes
module Carbuncle
  # This class is the baisc error, where all other errors extend from
  class Error < StandardError; end

  # This error is thrown when a game is attempt to start when one is already running.
  class GameIsRunning < Error; end

  # This error is thrown when a Filesystem error occurs.
  class FileError < Error; end

  # This error is thrown when the engine cannot found a specific file.
  class FileNotExists < FileError; end

  # Error thrown when the filesystem was not initialized and a File operation is attempted.
  class FilesystemNotInitialized < FileError; end

  # This error is thrown when attempting to read something than isn't a file
  class NotAFile < FileError; end

  # This error is thrown when an operation is attempted on a disposed object.
  class DisposedObject < Error; end
end
