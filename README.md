# Error report

docker-slim is unable to mount a file when running in compose mode

# Expectation

can run a compose file which mounts a file on a container which already has that file (overlay)

# Repoduction
Make the containers

```bash
make build
```

Run slim
```bash
docker-slim --state-path ./artifacts build --show-clogs --continue-after signal --http-probe-off --compose-file docker-compose.yml --target-compose-svc app1

docker-slim: message='join the Gitter channel to ask questions or to share your feedback' info='https://gitter.im/docker-slim/community'
docker-slim: message='join the Discord server to ask questions or to share your feedback' info='https://discord.gg/9tDyxYS'
docker-slim: message='Github discussions' info='https://github.com/docker-slim/docker-slim/discussions'
cmd=build state=started
cmd=build info=params target.type='compose.service' target='app1' continue.mode='signal' rt.as.user='true' keep.perms='true' tags='' 
cmd=build state=image.inspection.start
cmd=build info=image id='sha256:4fb4a59f68d0c7ca8d0959159cb87a5142095e0a261ed996dc9c264ee63c7011' size.bytes='927717314' size.human='928 MB' 
cmd=build info=image.stack index='0' name='python:3' id='sha256:4246fb19839fd033a0dd925c1f89cd1ad482c6b703d56f34bf0d2808b076e132' 
cmd=build info=image.stack index='1' name='app1:latest' id='sha256:4fb4a59f68d0c7ca8d0959159cb87a5142095e0a261ed996dc9c264ee63c7011' 
cmd=build state=image.inspection.done
cmd=build state=container.dependencies.init.start
time="2021-10-28T19:33:14Z" level=fatal msg="docker-slim: failure" error="API error (500): cannot mount volume over existing file, file exists /mnt/docker-data/overlay2/05aec8f5e982b130354d9a94a0cce1e64f5b7d2426d7f6ef903c2da84c5997da/merged/etc/nginx/conf.d/default.conf" stack="goroutine 1 [running]:\nruntime/debug.Stack(0x0, 0x0, 0x0)\n\truntime/debug/stack.go:24 +0x9f\ngithub.com/docker-slim/docker-slim/pkg/util/errutil.FailOn(0xfacb00, 0xc00055a220)\n\tgithub.com/docker-slim/docker-slim/pkg/util/errutil/errutil.go:28 +0x54\ngithub.com/docker-slim/docker-slim/pkg/app/master/commands/build.OnCommand(0xc00057a050, 0xc00057c410, 0xc00054a5d0, 0xb, 0x0, 0x7ffc1a850d3e, 0x12, 0x7ffc1a850d66, 0x4, 0x0, ...)\n\tgithub.com/docker-slim/docker-slim/pkg/app/master/commands/build/handler.go:566 +0x882e\ngithub.com/docker-slim/docker-slim/pkg/app/master/commands/build.glob..func1(0xc0000d6160, 0xc0000dc000, 0xc0000dc650)\n\tgithub.com/docker-slim/docker-slim/pkg/app/master/commands/build/cli.go:593 +0x2dc8\ngithub.com/urfave/cli.HandleAction(0xd1f2e0, 0xeb86b0, 0xc0000d6160, 0xc0000d6160, 0x0)\n\tgithub.com/urfave/cli@v1.22.4/app.go:526 +0xfd\ngithub.com/urfave/cli.Command.Run(0xe715ae, 0x5, 0x0, 0x0, 0x1542970, 0x1, 0x1, 0xeac7a7, 0x6c, 0x0, ...)\n\tgithub.com/urfave/cli@v1.22.4/command.go:174 +0x58e\ngithub.com/urfave/cli.(*App).Run(0xc0000cc000, 0xc0000300c0, 0xc, 0xc, 0x0, 0x0)\n\tgithub.com/urfave/cli@v1.22.4/app.go:279 +0x7e8\ngithub.com/docker-slim/docker-slim/pkg/app/master.Run()\n\tgithub.com/docker-slim/docker-slim/pkg/app/master/app.go:15 +0x54\nmain.main()\n\tgithub.com/docker-slim/docker-slim/cmd/docker-slim/main.go:8 +0x25\n" version="linux|Transformer|1.37.0|70cc8acfcb733161ce7e685b81ad6c172643c222|2021-09-23_09:23:43AM"
[arch@ip-10-0-3-165 load-balancing]$ ls

```

# Verifications of normal setup using docker-compose

```
docker-compose up -d
```

### Test
```
curl http://localhost:8080/
```
