---
layout: post
title: Installing RabbitMQ on Windows
date: '2018-05-17 20:33:14'
---
I recently had to install RabbitMQ manually on a Windows box. This is just checklist  documenting the steps that I took so I can remember it at a later stage. Don't do this a home unless you absolute have to. You should always prefer to run RabbitMQ on Linux or in a Docker container.

Here is a basic list of tasks that will get RabbitMQ up and running. Please consider security before you blindly apply this recipe.

Here we go:

1. Install Erlang OTP 20.3 64-bit version

    a. Download from [http://erlang.org/download/otp_win64_20.3.exe](http://erlang.org/download/otp_win64_20.3.exe)

    b. You must install Erlang using an administrative account

    c. Install in ``d:\app\`` or where ever your preferred location is. Accept all default setting

    d. Verify that ``ERLANG_HOME`` system variable is set to correct path ``D:\APP\erl9.3``. I have experienced that ``ERLANG_HOME`` was not set by the installer and then you need to define it manually

2. Install RabbitMQ Server 3.7.4

    a. Download from [https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.4/rabbitmq-server-3.7.4.exe](https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.4/rabbitmq-server-3.7.4.exe)

    b. Define system variable ``RABBITMQ_BASE`` to ``d:\app\RabbitMQ``

    c. Install in ``d:\app\rabbitmq server``

3. Enable Management Plugin from elevated command prompt

		cd d:\app\RabbitMQ Server\rabbitmq_server-3.7.4\sbin
		rabbitmq-plugins.bat enable rabbitmq_management
		rabbitmq-service.bat stop
		rabbitmq-service.bat remove
		rabbitmq-service.bat install
		rabbitmq-service.bat start

4. Verify that RabbitMQ is up and running
on the server by browse to

		http://localhost:15672/#/

    and log in with standard default username and password: guest/guest

5. Install Handle.exe for monitoring purposes

    a. Download from  [https://download.sysinternals.com/files/Handle.zip](https://download.sysinternals.com/files/Handle.zip)

    b. Install in ``d:\app\tools\handle``

    c. Add ``d:\app\tools\handle`` to system path

    d. Restart the RabbitMQ

		from command prompt
		cd d:\app\RabbitMQ Server\rabbitmq_server-3.7.4\sbin
		rabbitmq-service.bat stop
		rabbitmq-service.bat start 	

6. Open Ports

    Open Control Panel and navigate to System & Security. Now, open Windows Firewall. In the left-hand menu, click "Advanced settings" and create the following new inbound rules to the Windows firewall.

    The first one is for RabbitMQ, which uses 5672 as its main port and 15672 for its web admin:

    | Rule                  | Value                   |
    | --------------------- |------------------------:|
    | Rule Type             | Port                    |
    | Protocols and Ports   | TCP                     |
    | Specified local ports | 5672, 15672             |
    | Action                | Allow the connection    |
    | Profile               | Domain, Private, Public |
    | Name                  | RabbitMQ                |

    The next three rules are for Erlang:

    | Rule                  | Value                     |
    | --------------------- |--------------------------:|
    | Rule Type             | Program                   |
    | Program path          | D:\APP\erl9.3\bin\erl.exe |
    | Action                | Allow the connection      |
    | Profile               | Domain, Private, Public   |
    | Name                  | Erlang                    |

    | Rule                  | Value                     |
    | --------------------- |--------------------------:|
    | Rule Type             | Program                   |
    | Program path          | D:\APP\erl9.3\erts-9.3\bin\erl.exe |
    | Action                | Allow the connection      |
    | Profile               | Domain, Private, Public   |
    | Name                  | Erlang Run-Time System    |

    | Rule                  | Value                     |
    | --------------------- |--------------------------:|
    | Rule Type             | Program                   |
    | Program path          | D:\APP\erl9.3\erts-9.3\bin\epmd.exe |
    | Action                | Allow the connection      |
    | Profile               | Domain, Private, Public   |
    | Name                  | Erlang Port Mapper Daemon    |

7. Use correct Erlang cookie
copy ``C:\Windows\system32\config\systemprofile\.erlang.cookie``
to ``C:\Users\%USERNAME%\.erlang.cookie``

8. Create admin role from elevated command prompt

		cd d:\app\RabbitMQ Server\rabbitmq_server-3.7.4\sbin
		rabbitmqctl.bat add_user admin admin
		rabbitmqctl.bat set_user_tags admin administrator
		rabbitmqctl.bat set_permissions -p / admin ``".*" ".*" ".*"``

9. Verify that RabbitMQ web management can be accessed from external machine
From external machine by browsing to ``http://<machine-id>:15672/#/``
and log in with admin/admin

10. Create vhosts from elevated command prompt

		cd d:\app\RabbitMQ Server\rabbitmq_server-3.7.4\sbin
		rabbitmqctl.bat add_vhost my_vhost
		rabbitmqctl.bat list_vhosts

11. Create users and grant access rights from elevated command prompt

		cd d:\app\RabbitMQ Server\rabbitmq_server-3.7.4\sbin
		rabbitmqctl.bat add_user my_user my_user
		rabbitmqctl.bat set_permissions -p my_vhost my_user ".*" ".*" ".*"

12. Delete default user

		rabbitmqctl.bat delete_user guest
