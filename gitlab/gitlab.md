# GitLab self-managed

[Official documentation](https://docs.gitlab.com/15.9/ee/administration/server_hooks.html)

## Per-project configuration

1. Locating the project on the GitLab server’s file system. 
   1. Log into the GitLab instance as the System Administrator. 
   2. Head over to the admin area → overview → projects
   3. Select the project you’d like to configure the pre-receive hook on. 
   4. For example <https://gitlab.vcs.bridgecrew.cloud/admin/projects/mikeprivategroup/privategrouprepo>
   5. Copy the Gitaly relative path. This is where the script for the pre-receive hook will be set up. 
   6. Sample gitaly path - @hashed/3f/db/3fdba35f04dc8c462986c992bcf875546257113072a909c162f7e470e581e278.git
   7. The absolute path (generally) will be var/opt/gitlab/git-data/repositories + @hashed/xx/xx/xxxxxxxxxxxxx.git
2. Creating the pre-receive hook
   1. SSH into the GitLab server and navigate to the project directory on the file system. 
   2. Create a directory called custom_hooks.
   3. For creating a single hook, create a file with the name pre-receive with no extension. 
   4. For creating multiple hooks, create a directory called pre-receive.d and put the files in that directory. 
   5. For the sake of this example, create a pre-receive.d directory and a file called checkov-pre-receive-hook in that directory. 
   6. Ensure that the files in the pre-receive.d directory are executable and are owned by the git user. 
   7. Command: `chmod +x <filename>`
3. Script
   1. Copy the script to the checkov-pre-receive-hook file
4. Test by pushing to the repository.
