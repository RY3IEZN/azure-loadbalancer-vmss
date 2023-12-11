<!-- @format -->

Here is the steps we are going to follow

1. Create a Vnet
1. Create a loadbalancer with an empty backendpool
1. Create a Virtual Machine Scale set and add to the backend pool
1. Test out the loadbalancer

# A. Create a Virtual Network

Head over to the console and search for virtual network, so that we create a custom vpc, click create

![alt](/images/azalbvnet1.png)

Starting at this point we would also create our resource group which we will use to keep all our resources in, give your vpc a name, select your desired region and procced

![alt](/images/azalbvnet2.png)

You can skip the "Security" tab as we are not yet going to use Firewalls/DDos protection, however on the IP Address tab, we can set up the cidr block and the subnets. we need 2 subnets 1 for the vm and 1 for the gateway

![alt](/images/azalbvnet4.png)

When done click on "Review+create" and we should have our Vnet ready

![alt](/images/azalbvnet6.png)

# B. Create a loadbancer

We will be using a loadbalancer to distribute the traffic between the virtual machines on the console search for loadbalancer and click create

![alt](/images/azalb1.png)

Select loadbalancer type and click create

![alt](/images/azalb2.png)

Here we will set the specifications of the type of loadbalancer the tier

- sku - standard
- type - public
- tier - regional

![alt](/images/azalb3.png)

next give the loadbalancer a public ip

![alt](/images/azalb4.png)

The next step is to create a backend pool, so click on "add a backpool"

![alt](/images/azalb5a.png)

So, Select the virtual network we created and set the backend pool configuration to select available NIC,

As earlier mentioned, we will create an empty backend pool and later attach the vmss to it.

NB: This will help the loadbalancer to direct traffic to the new instances as the vmss scales out

![alt](/images/azalb5b.png)

next we create the inbound and outbounds rules, think of the rules as listeners and how it routes traffic to the pools.

for the inbound rules here are the specifications to use (the initial values are sometimes autofilled but can be changed)

- ip version - ipv4
- protocol - TCP
- Port - 80
- backend port
- session persistence - none

![alt](/images/azalb6.png)

for the outbound rules, the outbounds rules are used for the SNAT for backend (for the vms to be access the internet)

![alt](/images/azalb7.png)

Once done, go ahead click "review+create" and create the Loadbalancer

Once its up, click on the frontend configuration and then we can see the ip address of the loadbalancer

![alt](/images/azalb9.png)

# C. Create a VMSS

Here we are going to set up a virtual machine scale set, this will help us manage the scaling in and scaling out of our vm when the high/less traffic

Head over to the console and search for vmss

![alt](/images/azvmss.png)

select the desired region and select 2 or more availibility zone, this will help us achieve HA

![alt](/images/azvmss2a.png)

for the orchestration mode we will set it to "uniform" mode and choose the os and size with username and password

![alt](/images/azvmss2b.png)

for the networking, select the custom vpc we created and set the nic to not have public ip

![alt](/images/azvmss3a.png)

as for the loadbalncer section, we will azure loadbalancer and select the loadbalancer and the backend pool we created earlier

![alt](/images/azvmss3b.png)

The next tab is for handling autoscaling, here are the metrics we are going to use to hand scaling

- intial count = 2
- scaling policy = custom
- Min no of instance = 2
- max no of instance = 3
- Scale out when cpu utilisation is 90% for 30mins
- no of instance to add = 1

![alt](/images/azvmss4.png)

Nothing to do at the management tap to skip to health and enable application health check

![alt](/images/azvmss5.png)

For the advance tab, scroll down to user data and input the custom template and then click "review+create"

![alt](/images/azvmss6.png)

Once thats done we should see our vms with 2 already running

![alt](/images/azvmss7.png)

# D. Test out the loadbalancer

Now that we have everything set up we can now go ahead and test out the loadbalancer

Before we procced we have an important step to do,so that our vmss and loadbalancer can accept traffic. Procced to the NSG and open only port 80 to accept http traffic

![alt](/images/azalbtest1.png)

we can now go ahead and open the ipaddress of the loadbalancer on our browser

![alt](/images/azalbtest2.png)

We can see the hostname of one of the vm in the vmss, now refresh until you see the hostname of the other vm

![alt](/images/azalbtest3.png)

Great, our loadbalancer is working, and evenly distributing traffic between each vm and more as it scales up in the vmss

Enjoy!!!

🚧🚧🚧Dont forget to delete all your resources when you are done!🚧🚧🚧
