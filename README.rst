This dupper template repository is for Elasticsearch, Logstash, Kibana Stack.

ELK Stack
=========

This template install ELK Stack. You can start stack using below commands:

.. code-block:: bash

  dupper dup -t https://github.com/athakwani/elk
  dupper exec -t elk start
    
Commands
========

* start - Starts elk stack

.. code-block:: bash

    Usage:
    dupper exec -t elk start

* stop - Stops elk stack

.. code-block:: bash

    Usage:
    dupper exec -t elk stop

* get-cert - Generate & Download cerficate on your host at ~/.elk

.. code-block:: bash

    Usage:
    dupper exec -t elk get-cert

* join - Add host to ELK cluster 

.. code-block:: bash

    Usage:
    dupper exec -t elk join <server ip>

* unjoin - Remove host from ELK cluster
    
.. code-block:: bash

    Usage:
    dupper exec -t elk unjoin
