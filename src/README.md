<!-- @format -->

Here is the steps we are going to follow

1. Create a Vnet
1. Create a loadbalancer with an empty backendpool
1. Create a Virtual Machine Scale and add to the backend pool
1. Test out the loadbalancer

# A. Create a Virtual Network

Head over to the console and search for virtual network, so that we create a custom vpc, click create

![alt](/images/azalbvnet1.png)

Starting at this point we would also create our resource group which we will use to keep all our resources in, give your vpc a name, select your desired region and procced

![alt](/images/azalbvnet2.png)

You can skip the "Security" tab as we are not yet going to use Firewalls/DDos protection, however on the IP Address tab, we can set up the cidr block and the subnets. we need 2 subnets 1 for the vm and 1 for the gateway

![alt](/images/azalbvnet4.png)

When done click on "Review+create" and we should ave our Vnet ready

![alt](/images/azalbvnet6.png)

# B. Create a loadbancer

We will be using a loadbalancer to distribute the traffic between the virtual machines

on the console dearch for loadbalancer and click create

![alt](/images/azalb1.png)

Select loadbalancer type and click create

![alt](/images/azalb2.png)

# C. Create a VMSS

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
