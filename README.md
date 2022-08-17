# UNSW-CYBER-BOOTCAMP # Automated ELK Stack Deployment
University of Cyber BootCamp

The files in this repository were used to configure the network depicted below.

![Network Diagram](https://github.com/madhump/UNSW-CYBER-BOOTCAMP/blob/main/Diagrams/Network_Diagram.png.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YML file may be used to install only certain pieces of it, such as Filebeat.

  - [Ansible Hosts](Ansible/hosts.yml)
  - [Metricbeat Playbook](Ansible/roles/metricbeat-playbook.yml)
  - [Filebeat Playbook](Ansible/roles/filebeat-playbook.yml)
  - [Ansible Configuration](Ansible/ansible.cfg)
  - [Metricbeat Configuration File](Ansible/files/metricbeat-config.yml)
  - [Filebeat Configuration File](Ansible/files/filebeat-config.yml)
  - [ELK Playbook](Ansible/elkserversetup.yml)
  - [Pen Test Playbook (DVWA Containers)](Ansible/pentest.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

-------------------------------------------------------------------------------------------------------------------------------------------

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting traffic to the network.
- _What aspect of security do load balancers protect? What is the advantage of a jump box?_
  - Load balancers help ensure complete environment functionality and availability/accessibility, through the distribution of incoming data to several web servers.
  - Jump boxes allow for simplified administration of multiple systems and provide an additional layer between the outside and internal assets.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system logs.
- _What does Filebeat watch for?_
  - Filebeat monitors the log files or any other items/locations that you specify, collects log events, and forwards these logs to the ELK Server.
- _What does Metricbeat record?_
  - Metricbeat takes the metrics and statistics that it collects (for example, system metrics including CPU and disk usage, overall memory usage etc) and forwards this information to the Elk Server for review and further analysis.

The configuration details of each machine may be found below.

|    Name     |      Function      | IP Address | Operating System |
|-------------|--------------------|------------|------------------|
| Jump Box    | Gateway & Ansible  | 10.0.0.7   | Linux            |
| Web-1       | Ubuntu Web Server  | 10.0.0.11  | Linux            |
| Web-2       | Ubuntu Web Server  | 10.0.0.10  | Linux            |
| ELK-Server  | Base for ELK Stack | 10.1.0.5   | Linux            |

-------------------------------------------------------------------------------------------------------------------------------------------

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box Provisioner machine can accept connections from the Internet.
Access to this machine is only allowed from the following IP addresses:
- Personal/Public IP Address

Machines within the network can only be accessed by the Jump Box Provisioner.
- _Which machine did you allow to access your ELK VM?_
  - The Jump Box Provisioner (IP: 10.0.0.7) vis ssh (Port 22).
- _What was its IP address?_
  - The Public IP of the host machine can access the ELK VM.
A summary of the access policies in place can be found in the table below.

| Name      | Publicly Accessible | Allowed IP Addresses |
|-----------|---------------------|----------------------|
| Jump Box  | Yes                 | 20.213.72.162        |
| Web-1	    | No                  | 10.0.0.11            |
| Web-2	    | No                  | 10.0.0.10            |
| ELKserver | No	          | 20.213.72.162        |

-------------------------------------------------------------------------------------------------------------------------------------------

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
  - Ansible allows you to rapidly institute multi-level applications via the use of a pre-configured YAML playbook.
  - It has no dependency or requirement for use of any form of agents installed on remote systems. Therefore, overall maintenance and decreases in performance are heavily reduced.
  - Customised code does not need to be written in order to automate the systems you are setting up.  

The playbook implements the following tasks:
  - Specifies the group of machines and to become root user
  - Install docker.io
  - Install python3-pip and its associated docker module
  - Increase and Use More Virtual Memory
  - Download and launch the docker container for the elk server, to run on published ports:
    - 5601:5601 
    - 9200:9200 
    - 5044:5044
  - Enable the docker service to run upon system start

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Output](https://github.com/madhump/UNSW-CYBER-BOOTCAMP/blob/main/Images/docker_ps_output.png.png)

-------------------------------------------------------------------------------------------------------------------------------------------

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _10.0.0.7_ (DVWA-VM1)
- _10.0.0.10_ (Web-1)
- _10.0.0.11_ (Web-1)

We have installed the following Beats on these machines:
- _FileBeat_
- _MetricBeat_

These Beats allow us to collect the following information from each machine:
- Filebeat collects and transmits log files to the ELK Server. Filebeat monitors specified files, for example, the MySQL database of which supports this application, and forwards log files to Elasticsearch or Logstash for indexing and if needed, further review.
- Metricbeat, as per its namesake, collect metrics and statistics of the specified system. It monitors stats such as the CPU, Physical Memory, Disk Usage and Network usage among others.

-------------------------------------------------------------------------------------------------------------------------------------------

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the YML file to the ansible folder.
- Update the ansible.cfg file to include the remote user.
- Run the playbook, and navigate to http://(Private IP Address of the ELK VM):5601/app/kibana to check that the installation worked as expected.

- _Which file is the playbook? Where do you copy it?_
  - The files in the ansible/roles folder are the playbooks, which are moved to the ansible folder on the ansible machine for setup
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
  - The file requiring an update is update filebeat-config.yml. The hosts.yml file is then also update to reflect the ip addresses of the specify the machines in the group and also specifying the group that will be run on in ansible
- _Which URL do you navigate to in order to check that the ELK server is running?_
  - http://(External IP Address of the ELK VM):5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

| COMMAND                                             | RESULT                                                        |
|-----------------------------------------------------|---------------------------------------------------------------|                         
| `ssh-keygen`                                        |  Creates an ssh-key for us with the Virtual Machines          |
| `sudo cat .ssh/id_rsa.pub`                          |  Provides a copy of the ssh public key for use                |
| `ssh azadmin@(Jump box IP address)`                 |  Connect to the Jump-Box to access ansible containers         |
| `sudo docker container list -a`                     |  Provides a list of all docker containers with names          |
| `sudo docker start (for example: wonderful_ellis)`  |  Starts the named docker container                            |
| `sudo docker ps -a`                                 |  Provides a list of all active/inactive containers            |
| `sudo docker attach (for example: wonderful_ellis)` |  Connects into named docker container                         |
| `cd /etc/ansible`                                   |  Enter the ansible directory                                  |
| `nano /etc/ansible/hosts`                           |  Opens the hosts file in an editable window                   |
| `nano /etc/ansible/ansible.cfg`                     |  Opens the ansible.cfg file in an editable window             |
| `nano /etc/ansible/pentest.yml`                     |  Opens the pentest.yml file in an editable window             |
| `ansible-playbook [location][filename]`             |  Runs the specified playbook                                  |
| `ssh ansible@(Web-1 IP address)`                    |  Connects and logs into the Web-1 Virtual Machine             |
| `ssh ansible@(Web-2 IP address)`                    |  Connects and logs into the Web-2 Virtual Machine             |
| `ssh ansible@(DVWA-VM1 IP address)`                 |  Connects and logs into the DVWA-VM1 Virtual Machine          |
| `ssh ansible@(ELK Server IP address)`               |  Connects and logs into the ELK Server Virtual Machine        |
| `exit`                                              |  Exits out of any instance back into the previous one         |
| `nano filebeat-config.yml`                          |  Opens the filebeat-config.yml file in an editable window     |
| `nano filebeat-playbook.yml`                        |  Opens the filebeat-playbook.yml file in an editable window   |
| `nano metricbeat-config.yml`                        |  Opens the metricbeat-config.yml file in an editable window   |
| `nano metricbeat-playbook.yml`                      |  Opens the metricbeat-playbook.yml file in an editable window |   

-------------------------------------------------------------------------------------------------------------------------------------------
