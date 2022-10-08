- hosts: host1 host2 host3 host4
  name: netplan
  become: yes
  gather_facts: no
  tasks:
    - name: cloud file entfernen
      ansible.builtin.file:
        path: /etc/netplan/50-cloud-init.yaml
        state: absent
    - name: cloud file entfernen
      ansible.builtin.file:
        path: /etc/netplan/config.yaml
        state: absent
    - name: copy netplan yaml
      copy:
        src: /home/cumulus/ON-12/practice-02-{{ inventory_hostname }}.yaml
        dest: /etc/netplan/config.yaml
    - name: apply netplan yaml
      shell: netplan apply
       
    - name: Check interface 2
      shell: /sbin/ip -br -4 a | grep 'eth2'
      ignore_errors: yes
      register: result
    - debug: msg={{ result.stdout }}

# Leaf1 

- hosts: leaf1
  name: Leaf1 Interfaces
  become: yes
  gather_facts: no
  tasks:
    - name: IF clean up
      copy: 
        src: /home/cumulus/ON-12/cleanup-switches-if
        dest: /etc/network/interfaces
    # aktivieren
    - name: activate changes on Leaf1
      shell: /sbin/ifreload -a
      
# Leaf01 routing      
      
- hosts: leaf1
  name: Routing cleanup
  become: yes
  gather_facts: no
  tasks:
    - name: clean up
      copy:
        src: /home/cumulus/ON-12/cleanup-leaf-1-frr
        dest: /etc/frr/frr.conf
      notify:
        - frr_reload
        
  handlers:
    - name: frr_reload
      service:
        name=frr
        state=reloaded
      listen: "frr_reload"
      
# #################################################################

# Leaf2 

- hosts: leaf2
  name: Leaf2 Interfaces
  become: yes
  gather_facts: no
  tasks:
    - name: IF clean up
      copy: 
        src: /home/cumulus/ON-12/cleanup-switches-if
        dest: /etc/network/interfaces
    # aktivieren
    - name: activate changes on Leaf2
      shell: /sbin/ifreload -a
      
# Leaf02 routing      
      
- hosts: leaf2
  name: Routing cleanup
  become: yes
  gather_facts: no
  tasks:
    - name: clean up
      copy:
        src: /home/cumulus/ON-12/cleanup-leaf-2-frr
        dest: /etc/frr/frr.conf
      notify:
        - frr_reload
        
  handlers:
    - name: frr_reload
      service:
        name=frr
        state=reloaded
      listen: "frr_reload"
    
# #################################################################

# Spine3 

- hosts: spine3
  name: Leaf1 Interfaces
  become: yes
  gather_facts: no
  tasks:
    - name: IF clean up
      copy: 
        src: /home/cumulus/ON-12/cleanup-switches-if
        dest: /etc/network/interfaces
    # aktivieren
    - name: activate changes on Spine3
      shell: /sbin/ifreload -a
      
# Spine3 routing      
      
- hosts: spine3
  name: Routing cleanup
  become: yes
  gather_facts: no
  tasks:
    - name: clean up
      copy:
        src: /home/cumulus/ON-12/cleanup-spine-3-frr
        dest: /etc/frr/frr.conf
      notify:
        - frr_reload
        
  handlers:
    - name: frr_reload
      service:
        name=frr
        state=reloaded
      listen: "frr_reload"
      
      
# #################################################################

# Spine4 

- hosts: spine4
  name: Spine4 Interfaces
  become: yes
  gather_facts: no
  tasks:
    - name: IF clean up
      copy: 
        src: /home/cumulus/ON-12/cleanup-switches-if
        dest: /etc/network/interfaces
    # aktivieren
    - name: activate changes on Spine4
      shell: /sbin/ifreload -a
      
# Leaf01 routing      
      
- hosts: spine4
  name: Routing cleanup
  become: yes
  gather_facts: no
  tasks:
    - name: clean up
      copy:
        src: /home/cumulus/ON-12/cleanup-spine-4-frr
        dest: /etc/frr/frr.conf
      notify:
        - frr_reload
        
  handlers:
    - name: frr_reload
      service:
        name=frr
        state=reloaded
      listen: "frr_reload"
