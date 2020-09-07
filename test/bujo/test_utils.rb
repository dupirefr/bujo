def execute_in_test_directory(action)
  working_directory = Dir.pwd
  test_directory = Dir.mktmpdir("bujo")
  Dir.chdir(test_directory) do
    action.call(working_directory)
  end
end