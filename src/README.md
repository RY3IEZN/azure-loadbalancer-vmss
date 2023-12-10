<!-- @format -->

# C. Test out the loadbalancer

Now that we have everything set up we can now go ahead and test out the loadbalancer

Before we procced we have an important step to do,so that our vmss and loadbalancer can accept traffic. Procced to the NSG and open only port 80 to accept http traffic

![alt](/images/azalbtest1.png)

we can now go ahead and open the ipaddress of the loadbalancer on our browser

![alt](/images/azalbtest2.png)

We can see the hostname of one of the vm in the vmss, now refresh until you see the hostname of the other vm

![alt](/images/azalbtest3.png)
