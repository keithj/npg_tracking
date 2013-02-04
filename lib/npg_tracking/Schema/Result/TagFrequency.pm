package npg_tracking::Schema::Result::TagFrequency;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

npg_tracking::Schema::Result::TagFrequency

=cut

__PACKAGE__->table("tag_frequency");

=head1 ACCESSORS

=head2 id_tag_frequency

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 id_tag

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 id_entity_type

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 frequency

  data_type: 'bigint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_tag_frequency",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "id_tag",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "id_entity_type",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "frequency",
  {
    data_type => "bigint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
);
__PACKAGE__->set_primary_key("id_tag_frequency");

=head1 RELATIONS

=head2 entity_type

Type: belongs_to

Related object: L<npg_tracking::Schema::Result::EntityType>

=cut

__PACKAGE__->belongs_to(
  "entity_type",
  "npg_tracking::Schema::Result::EntityType",
  { id_entity_type => "id_entity_type" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 tag

Type: belongs_to

Related object: L<npg_tracking::Schema::Result::Tag>

=cut

__PACKAGE__->belongs_to(
  "tag",
  "npg_tracking::Schema::Result::Tag",
  { id_tag => "id_tag" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-09-07 09:30:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Y797U+UNDdbm/ep3x6kMRw
# Author:        david.jackson@sanger.ac.uk
# Maintainer:    $Author: jo3 $
# Created:       2010-04-08
# Last Modified: $Date: 2010-09-13 18:21:28 +0100 (Mon, 13 Sep 2010) $
# Id:            $Id: TagFrequency.pm 10867 2010-09-13 17:21:28Z jo3 $
# $HeadURL: svn+ssh://svn.internal.sanger.ac.uk/repos/svn/new-pipeline-dev/npg-tracking/trunk/lib/npg_tracking/Schema/Result/TagFrequency.pm $

use Readonly; Readonly::Scalar our $VERSION => do { my ($r) = q$LastChangedRevision: 10867 $ =~ /(\d+)/mxs; $r; };

1;
