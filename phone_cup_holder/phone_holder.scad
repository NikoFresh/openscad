include <../lib/BOSL2/std.scad>

$fn = 100;

base_radius = 31.5;
base_height = 3;
obj_height = 80;
center_rise = 12;
phone_space = 15;
wall_width = 3;

wall_height = obj_height - base_height;
actual_center_rise = center_rise - base_height;

module copy_mirror(vec)
{
    children();
    mirror(vec) children();
}

module phone_holder()
{
    // base
    up(base_height / 2) cyl(l = base_height, r1 = base_radius - .5, r2 = base_radius);

    // walls
    intersection()
    {
        up((wall_height / 2) + base_height) cyl(h = wall_height, r = base_radius, rounding2 = 5);
        copy_mirror([ 1, 0, 0 ])
            translate(v = [ (phone_space / 2) + (wall_width / 2), 0, (wall_height / 2) + base_height ])
                cuboid([ wall_width, base_radius * 2, wall_height ], rounding = -4, edges = [BOT], $fn = 24);
    }

    // internal rise
    intersection()
    {
        cyl(h = obj_height, r = base_radius);
        translate(v = [ 0, 0, (actual_center_rise / 2) + base_height ])
            cuboid([ phone_space, base_radius * 2, actual_center_rise ]);
    }
}

phone_holder();