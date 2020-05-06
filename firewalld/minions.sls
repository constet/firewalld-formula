{% for state, config in firewalld.restrict_minions.items() %}

{% if config.enabled %}
saltmaster:
  firewalld.service:
    - name: saltmaster
    - ports:
      - 4505/tcp
      - 4506/tcp

saltzone:
  firewalld.present:
    - name: saltzone
    - services:
      - saltmaster
    - sources:
{% for ip in config.ips %}
      - {{ ip }}
{% endfor %}

{% endif %}
{% endfor %}
