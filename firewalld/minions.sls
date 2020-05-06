{% for state, config in firewalld.restrict_minions.items() %}

{% if config.enabled %}
saltmaster:
  firewalld.service:
    - name: saltmaster
    - ports:
      - 4505/tcp
      - 4506/tcp

{% for ip in config.ips %}
saltzone:
  firewalld.present:
    - name: saltzone
    - services:
      - saltmaster
    - sources:
      - {{ ip }}
{% endfor %}
{% endif %}
{% endfor %}
