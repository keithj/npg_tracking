package npg_tracking::Schema::Result::Annotation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

npg_tracking::Schema::Result::Annotation

=cut

__PACKAGE__->table("annotation");

=head1 ACCESSORS

=head2 id_annotation

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 id_user

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 date

  data_type: 'datetime'
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 comment

  data_type: 'text'
  is_nullable: 0

=head2 attachment_name

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 attachment

  data_type: 'longblob'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id_annotation",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "id_user",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "date",
  {
    data_type     => "datetime",
    default_value => "0000-00-00 00:00:00",
    is_nullable   => 0,
  },
  "comment",
  { data_type => "text", is_nullable => 0 },
  "attachment_name",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "attachment",
  { data_type => "longblob", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id_annotation");

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<npg_tracking::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "npg_tracking::Schema::Result::User",
  { id_user => "id_user" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 instrument_annotations

Type: has_many

Related object: L<npg_tracking::Schema::Result::InstrumentAnnotation>

=cut

__PACKAGE__->has_many(
  "instrument_annotations",
  "npg_tracking::Schema::Result::InstrumentAnnotation",
  { "foreign.id_annotation" => "self.id_annotation" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 instrument_status_annotations

Type: has_many

Related object: L<npg_tracking::Schema::Result::InstrumentStatusAnnotation>

=cut

__PACKAGE__->has_many(
  "instrument_status_annotations",
  "npg_tracking::Schema::Result::InstrumentStatusAnnotation",
  { "foreign.id_annotation" => "self.id_annotation" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 run_annotations

Type: has_many

Related object: L<npg_tracking::Schema::Result::RunAnnotation>

=cut

__PACKAGE__->has_many(
  "run_annotations",
  "npg_tracking::Schema::Result::RunAnnotation",
  { "foreign.id_annotation" => "self.id_annotation" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 run_lane_annotations

Type: has_many

Related object: L<npg_tracking::Schema::Result::RunLaneAnnotation>

=cut

__PACKAGE__->has_many(
  "run_lane_annotations",
  "npg_tracking::Schema::Result::RunLaneAnnotation",
  { "foreign.id_annotation" => "self.id_annotation" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-10-27 15:57:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/HuH+2giL1yzJksUdrm2lQ
# Author:        david.jackson@sanger.ac.uk
# Maintainer:    $Author: dj3 $
# Created:       2010-04-08
# Last Modified: $Date: 2010-11-08 15:02:27 +0000 (Mon, 08 Nov 2010) $
# Id:            $Id: Annotation.pm 11663 2010-11-08 15:02:27Z dj3 $
# $HeadURL: svn+ssh://svn.internal.sanger.ac.uk/repos/svn/new-pipeline-dev/npg-tracking/trunk/lib/npg_tracking/Schema/Result/Annotation.pm $

use Readonly; Readonly::Scalar our $VERSION => do { my ($r) = q$LastChangedRevision: 11663 $ =~ /(\d+)/mxs; $r; };

1;
