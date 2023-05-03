# Bitbucket Server

[Official documentation](https://confluence.atlassian.com/bitbucketserverkb/how-to-create-a-simple-hook-in-bitbucket-server-779171711.html)

## Per-project configuration

1. Identify the repository ID on the file system - docs
2. Navigate to the repository on the file system
3. Sample path - /var/atlassian/application-data/bitbucket/shared/data/repositories/6075
4. Go to the hooks/pre-receive.d directory for that repository
5. Create a new file with the name 21_pre_receive. 
6. Note that the prefixed number dictates the order in which the hook will be executed. It should be greater than 20.
7. Ensure that the file has the execute permission for the bitbucket user.
8. Test by pushing to the repository.
