# Accessing data on s3://genomeark

!!! IMPORTANT: VGP samples and data come from a variety of sources. To support fair and productive use of this data, please abide by the [*Data Use Policy*](https://genome10k.soe.ucsc.edu/data-use-policies/) and contact us with any questions. !!!

## Access via AWS cli
Amazon Web Service (AWS) provides a command line interface (cli) to easily retrieve, download, upload data on a s3 bucket.
The instructions here are for downloading data on the genomeark.

### Installation

```
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip”
unzip awscli-bundle.zip
./awscli-bundle/install -i $path_to_install

# Add aws cli to your environment path
export PATH=$path_to_install/bin:$PATH
```

See [installation guide](https://docs.aws.amazon.com/cli/latest/userguide/awscli-install-bundle.html#install-bundle-user) for more details.

### List and download
```
aws s3 --no-sign-request ls s3://genomeark/species/Calypte_anna/
aws s3 --no-sign-request cp s3://genomeark/data_use_policies.txt .
```

Read through the data_use_policies.txt.

Data structures follow the rule `s3://genomeark/species/<species_name>/<genome_id>/`
For example,
```
aws s3 ls s3://genomeark/species/Calypte_anna/bCalAnn1/
```
Will show you what’s under <i>Calypte anna</i>, the hummingbird genome.

See [DNAnexus_and_AWS_data_structure.md](https://github.com/VGP/vgp-assembly/blob/master/DNAnexus_and_AWS_data_structure.md) for more details.
