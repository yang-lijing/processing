size(255,255);
loadPixels();
for (int x = 0; x < width; x ++) {
for (int y = 0; y < height; y ++) {
int loc =x+y*width;
float distance =sqrt((x-width/2)*(x-width/2)+(y-height/2)*(y-height/2));
pixels[loc] =color(255-distance);
}
}
updatePixels();