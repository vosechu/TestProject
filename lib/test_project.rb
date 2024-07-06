# frozen_string_literal: true

class TestProject
  def bananas
    'bananas'
  end
end

# Run this code only when started from the command-line
if __FILE__ == $0
  test_project = TestProject.new
  puts test_project.bananas
  # Rest of the code goes here
end
