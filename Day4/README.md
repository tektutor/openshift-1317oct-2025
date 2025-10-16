# Day 4

## Info - Persistent Volume
<pre>
- is an exter
- is a piece of storage in the Openshift cluster that is provisioned by Openshift Administrator
- it can be either manually provisioned by Openshift Administrator or Dynamically Provisioned
- Persistent Volume can be be provisioned by following backends
  - NFS
  - iSCSI
  - Ceph
  - AWS EBS
  - GlusterFS
  - etc
- Persistent Volumes usually will have the follow properties
  - Size in Mi, Gi, Ti
  - Access Mode
    - ReadWriteOnce, ReadWriteMany, ReadOnlyMany, ReadOnlyOnce, ReadWriteOncePod
  - StorageClass (optional) - in case provisioned dynamically
  - Labels ( Optional )
</pre>
