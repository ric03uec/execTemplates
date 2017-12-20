#
# Used to generate the envs for the boot and task scripts
#

<% _.each(obj.commonEnvs, function (commonEnv) { %>
{
  export <%= commonEnv.key %>="<%= commonEnv.value %>";
} || {
  exec_cmd "echo 'An error occurred while trying to export an environment variable: <%= commonEnv.key %> '"
  return 1
}
<% }); %>

<% _.each(obj.taskEnvs, function (taskEnv) { %>
{
  export <%= taskEnv.key %>="<%= taskEnv.value %>";
} || {
  exec_cmd "echo 'An error occurred while trying to export an environment variable: <%= taskEnv.key %> '"
  return 1
}
<% }); %>

export SHIPPABLE_NODE_ARCHITECTURE="<%= obj.shippableRuntimeEnvs.shippableNodeArchitecture %>"
export SHIPPABLE_NODE_OPERATING_SYSTEM="<%= obj.shippableRuntimeEnvs.shippableNodeOperatingSystem %>"
export TASK_NAME="<%= obj.shippableRuntimeEnvs.taskName %>"
export TASK_IN_CONTAINER=<%= obj.shippableRuntimeEnvs.isTaskInContainer %>
if [ "$TASK_IN_CONTAINER" == true ]; then
  export TASK_CONTAINER_OPTIONS="<%= obj.shippableRuntimeEnvs.taskContainerOptions %>"
  export TASK_CONTAINER_IMAGE="<%= obj.shippableRuntimeEnvs.taskContainerImage %>"
  export TASK_CONTAINER_IMAGE_SHOULD_PULL="<%= obj.shippableRuntimeEnvs.shouldPullTaskContainerImage %>"
  export TASK_CONTAINER_COMMAND="<%= obj.shippableRuntimeEnvs.taskContainerCommand %>"
fi
