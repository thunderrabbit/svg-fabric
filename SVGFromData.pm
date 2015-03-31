package SVGFromData;
use strict;
use warnings;
  
use SVG;

sub new {
    my ($class, $width, $height) = @_;

    my $svg = SVG->new(
        width  => $width,
        height => $height
    );

    # width and height aren't used yet
    # x and y are pointers to current width and height or height and width not sure yet
    my $self = { 
        svg => $svg, 
        width => $width, 
        height => $height,
        x => 0,
        y => 0
    };
    bless $self, $class;
    return $self;
}
  
# create rectangle that spans the entire image
# each next time it's called, move the subsequent
# rectangle down so they are adjacent
sub horizontalBar {
    my ($self, $obj) = @_;

    my $svg = $self->{svg};
    my $y = $self->{y};
    my $width = $self->{width};

    my $bar_height = $obj->{height};
    my $bar_color = $obj->{color};
    my $bar_opacity = $obj->{opacity};

    $svg->rectangle(
        x => 0,
        y => $y,
        width  => $width,
        height => $bar_height,
        style => {
            'fill'           => $bar_color,
            'stroke'         => 'black',
            'stroke-width'   =>  0,
            'stroke-opacity' =>  1,
            'fill-opacity'   =>  $bar_opacity,
        },
    );

    $self->{y} += $bar_height;
}

# create rectangle as tall as the entire image
# each next time it's called, move the subsequent
# rectangle over so they are adjacent
sub verticalBar {
    my ($self, $obj) = @_;

    my $svg = $self->{svg};
    my $x = $self->{x};
    my $height = $self->{height};

    my $bar_width = $obj->{width};
    my $bar_color = $obj->{color};
    my $bar_opacity = $obj->{opacity};

    $svg->rectangle(
        x => $x,
        y => 0,
        width => $bar_width,
        height  => $height,
        style => {
            'fill'           => $bar_color,
            'stroke'         => 'black',
            'stroke-width'   =>  0,
            'stroke-opacity' =>  1,
            'fill-opacity'   =>  $bar_opacity,
        },
    );

    $self->{x} += $bar_width;
}

sub xmlify {
    my ($self) = @_;

    my $svg = $self->{svg};

    print $svg->xmlify();
}

1;  # if we reach this point, we imagine the module loaded correctly