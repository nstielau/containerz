include_recipe "nano"
include_recipe "apache"
include_recipe "nginx"

# Install Helper utilities
include_recipe "containerz::utilities"


# include_recipe "lxc"
# include_recipe "lmctfy"

file "/root/hi.txt" do
  content "Hello!"
end

# cgget, cgset, etc
package "libcgroups-tools"