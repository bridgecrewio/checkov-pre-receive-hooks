# GitHub Enterprise

[Official documentation](https://docs.github.com/en/enterprise-server@3.4/admin/policies/enforcing-policy-with-pre-receive-hooks/managing-pre-receive-hooks-on-the-github-enterprise-server-appliance#creating-pre-receive-hooks)

## Per-project & all project configuration

1. Log into the GitHub web UI using admin credentials. 
2. Click your profile photo at the top right corner and go to Enterprise Settings.
3. Select Settings → Hooks → Add pre-receive hook.
4. Name the hook checkov-pre-receive and select the environment for executing the hook (pick the default one unless you have specific requirements).
5. Pick the repository that has the pre-receive receive hook and select the appropriate file name. 
6. You have the option to check the enable hook on all repositories by default option here. 
7. The hook can be added to a GitHub organization or a single repository from the organization and repository settings section respectively. 
