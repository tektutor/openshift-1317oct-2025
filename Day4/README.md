# Day 4

## Info - Persistent Volume (PV)
<pre>
- is an external storage used by applications that needs storage
- is a piece of storage in the Openshift cluster that is provisioned by Openshift Administrator
- it can be either manually provisioned by Openshift Administrator or Dynamically Provisioned
- Persistent Volume can be be provisioned by following backends
  - NFS
  - iSCSI
  - Ceph
  - AWS EBS
  - GlusterFS
  - etc
- PVs are cluster scoped, it is accessible by applications from any Project namespace
- Persistent Volumes usually will have the follow properties
  - Storage Size in Mi, Gi, Ti
  - Access Mode
    - ReadWriteOnce, ReadWriteMany, ReadOnlyMany, ReadOnlyOnce, ReadWriteOncePod
  - StorageClass (optional) - in case provisioned dynamically
  - Labels ( Optional )
</pre>

## Info - Persistent Volume Claim (PVC)
<pre>
- is a request for storage by your application
- any application that needs external storage to peristent their application logs or data will have request by creating PVC
- Project namespace scoped ( tied to a project )
- Key Properties
  - Storage Size in Mi, Gi, Ti, etc.,
  - Access Mode
  - StorageClass (Optional)
  - Labels (Optional)
- If the Storage Controller is able to find an exact match of PV as per your PVC request then it will let your PVC bound and use it in your application deployments
</pre>

## Lab - Kindly check to verify NFS shared folder allocated for you
Replace 'jegan' with your name
```
showmount -e | grep jegan
```

## Lab - Deploying Worpress and Mariadb multi-pod application to host a blog website
```
cd ~/openshift-1317oct-2025
git pull
cd Day4/wordpress
# Make sure you replace 'jegan' with your name in mysql-pv.yml mysql-pvc.yml mysql-deploy.yml wordpress-pv.yml wordpress-pvc.yml wordpress-deploy.yml

# Also make sure the NFS Server IP is updated to 192.168.3.200 if you are working in Server 1 other to 192.168.3.201
./deploy.sh
```
