
control_plane_nodepools = [
{
    name        = "control-plane-fsn1",
    server_type = "cpx11",
    location    = "fsn1",
    labels      = [],
    taints      = [],
    count       = 1
    swap_size   = "2G" # remember to add the suffix, examples: 512M, 1G
    zram_size   = "2G" # remember to add the suffix, examples: 512M, 1G
    kubelet_args = ["kube-reserved=cpu=250m,memory=1500Mi,ephemeral-storage=1Gi", "system-reserved=cpu=250m,memory=300Mi"]

    # Fine-grained control over placement groups (nodes in the same group are spread over different physical servers, 10 nodes per placement group max):
    # placement_group = "default"

    # Enable automatic backups via Hetzner (default: false)
    # backups = true
},
{
    name        = "control-plane-nbg1",
    server_type = "cpx11",
    location    = "nbg1",
    labels      = [],
    taints      = [],
    count       = 1
    swap_size   = "2G" # remember to add the suffix, examples: 512M, 1G
    zram_size   = "2G" # remember to add the suffix, examples: 512M, 1G
    kubelet_args = ["kube-reserved=cpu=250m,memory=1500Mi,ephemeral-storage=1Gi", "system-reserved=cpu=250m,memory=300Mi"]

    # Fine-grained control over placement groups (nodes in the same group are spread over different physical servers, 10 nodes per placement group max):
    # placement_group = "default"

    # Enable automatic backups via Hetzner (default: false)
    # backups = true
},
{
    name        = "control-plane-hel1",
    server_type = "cpx11",
    location    = "hel1",
    labels      = [],
    taints      = [],
    count       = 1
    swap_size   = "2G" # remember to add the suffix, examples: 512M, 1G
    zram_size   = "2G" # remember to add the suffix, examples: 512M, 1G
    kubelet_args = ["kube-reserved=cpu=250m,memory=1500Mi,ephemeral-storage=1Gi", "system-reserved=cpu=250m,memory=300Mi"]

    # Fine-grained control over placement groups (nodes in the same group are spread over different physical servers, 10 nodes per placement group max):
    # placement_group = "default"

    # Enable automatic backups via Hetzner (default: false)
    # backups = true
}
]

agent_nodepools = [
{
    name        = "agent-small",
    server_type = "cpx11",
    location    = "fsn1",
    labels      = [],
    taints      = [],
    count       = 1
    swap_size   = "1G" # remember to add the suffix, examples: 512M, 1G
    zram_size   = "1G" # remember to add the suffix, examples: 512M, 1G
    kubelet_args = ["kube-reserved=cpu=50m,memory=300Mi,ephemeral-storage=1Gi", "system-reserved=cpu=250m,memory=300Mi"]

    # Fine-grained control over placement groups (nodes in the same group are spread over different physical servers, 10 nodes per placement group max):
    # placement_group = "default"

    # Enable automatic backups via Hetzner (default: false)
    # backups = true
},
{
    name        = "agent-large",
    server_type = "cpx21",
    location    = "nbg1",
    labels      = [],
    taints      = [],
    count       = 1
    swap_size   = "1G" # remember to add the suffix, examples: 512M, 1G
    zram_size   = "1G" # remember to add the suffix, examples: 512M, 1G
    kubelet_args = ["kube-reserved=cpu=50m,memory=300Mi,ephemeral-storage=1Gi", "system-reserved=cpu=250m,memory=300Mi"]

    # Fine-grained control over placement groups (nodes in the same group are spread over different physical servers, 10 nodes per placement group max):
    # placement_group = "default"

    # Enable automatic backups via Hetzner (default: false)
    # backups = true
},
{
    name        = "storage",
    server_type = "cpx21",
    location    = "fsn1",
    # Fully optional, just a demo.
    labels      = [
    "node.kubernetes.io/server-usage=storage"
    ],
    taints      = [],
    count       = 1

    # In the case of using Longhorn, you can use Hetzner volumes instead of using the node's own storage by specifying a value from 10 to 10000 (in GB)
    # It will create one volume per node in the nodepool, and configure Longhorn to use them.
    # Something worth noting is that Volume storage is slower than node storage, which is achieved by not mentioning longhorn_volume_size or setting it to 0.
    # So for something like DBs, you definitely want node storage, for other things like backups, volume storage is fine, and cheaper.
    # longhorn_volume_size = 20

    # Enable automatic backups via Hetzner (default: false)
    # backups = true
},
# Egress nodepool useful to route egress traffic using Hetzner Floating IPs (https://docs.hetzner.com/cloud/floating-ips)
# used with Cilium's Egress Gateway feature https://docs.cilium.io/en/stable/gettingstarted/egress-gateway/
# See the https://github.com/kube-hetzner/terraform-hcloud-kube-hetzner#examples for an example use case.
{
    name        = "egress",
    server_type = "cx21",
    location    = "fsn1",
    labels = [
    "node.kubernetes.io/role=egress"
    ],
    taints = [
    "node.kubernetes.io/role=egress:NoSchedule"
    ],
    floating_ip = true
    count = 1
},
# Arm based nodes
{
    name        = "agent-arm-small",
    server_type = "cax11",
    location    = "fsn1",
    labels      = [],
    taints      = [],
    count       = 1
},
# For fine-grained control over the nodes in a node pool, replace the count variable with a nodes map.
# In this case, the node-pool variables are defaults which can be overridden on a per-node basis.
# Each key in the nodes map refers to a single node and must be an integer string ("1", "123", ...).

/* {
    name        = "agent-arm-small",
    server_type = "cax11",
    location    = "fsn1",
    labels      = [],
    taints      = [],
    nodes = {
    "1" : {
        location                  = "nbg1"
        labels = [
        "testing-labels=a1",
        ]
    },
    "20" : {
        labels = [
        "testing-labels=b1",
        ]
    }
    }
}, */

]