$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'fssm'
require 'grit'

# Setup default path
@@repo_folder = "./repositories" # no trailing /

# Check arguments, only 1 allowed: path to repos
ARGV.each do|a|
  @@repo_folder = a
end

# Strip last / if there is one
if(@@repo_folder[-1,1] === '/')
  @@repo_folder = @@repo_folder[0, @@repo_folder.length - 1]
end

# Retrieve the project name from a path
def getProjectFromPath(path)
  folders = path.split('/')
  return folders[folders.index(".git") - 1]
end

# Do something with a change (get last commit message)
def act(base, relative)
  project = getProjectFromPath(base)
  
  # Create new repo and read last commit
  repo = Grit::Repo.new(File.join(@@repo_folder, project))
  puts "#{repo.commits.first.author.email} in #{project}: #{repo.commits.first.message}"

#  repo.commits.each do |commit|
#    puts "#{commit.author.email}: #{commit.message}"
#    commit.tree.contents.each do |entry|
#      puts "-#{entry.name}"
#    end
#  end
end

# Get a list of all repos to be watched
repos = Pathname.glob("#{@@repo_folder}/*/")

# Setup FSSM to watch the .git/refs/heads folder for changes
FSSM.monitor do
  repos.each do |repo|
    path File.join(repo, 'refs', 'heads') do
      update { |b,r| act(b,r) } 
      delete { |b,r| act(b,r) }
      create { |b,r| act(b,r) }
    end
  end
  puts "Watching #{@@repo_folder} for changes.."
end



