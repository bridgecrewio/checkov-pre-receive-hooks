# Testing locally

1. Clone this repository: <https://github.com/bridgecrewio/checkov-pre-receive-hooks>
2. Navigate to the local folder and build the image from Dockerfile.dev

```sh
docker build -f Dockerfile.dev -t pre-receive.dev .
```

3. Add executable permissions to the checkov-pre-receive.sh file 

```sh
chmod +x checkov-pre-receive.sh
```

4. Run a data container that contains a generated SSH key

```sh
docker run --name data pre-receive.dev /bin/true
```

5. Copy the script to the data container

```sh
docker cp checkov-pre-receive.sh data:/home/git/test.git/hooks/pre-receive
```

6. Run an application container to execute the hook

```sh
docker run -d -p 52311:22 --volumes-from data pre-receive.dev
```

7. Copy the generated ssh key to your local machine

```sh
docker cp data:/home/git/.ssh/id_ed25519 .
```

8. In a test repository on your local machine, make a commit. Then run the following command to test the hook

```sh
git remote add test git@127.0.0.1:test.git
$ GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 52311 -i ../id_ed25519" git push -u test main
```
