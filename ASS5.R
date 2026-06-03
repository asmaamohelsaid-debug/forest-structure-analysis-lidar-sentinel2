# ========================================================
# Unit: Introduction to LiDAR Remote Sensing
# ========================================================

# --- 1. Installation & Loading Libraries ---

install.packages("lidR")

library(lidR)
library(terra)


# --- 2. Load LiDAR Data ---
# Read the clipped Lahntal LiDAR data from the new subdirectory
las <- readLAS("data/lidar/lidar_2018_clipped.las")

# Print the data summary in the console to verify it loaded correctly
print(las)


# --- 3. Visual Data Exploration ---
# Plot 1: Default 3D visualization (Colored by Z / Elevation)
plot(las)

# Plot 2: Experiment with coloring by "Intensity"
plot(las, color = "Intensity")

# Plot 3: Experiment with coloring by "Classification"
plot(las, color = "Classification")


# --- 4. Attribute Filter ---
# Filter the LiDAR data to keep only points with Intensity < 300
las_filtered <- filter_poi(las, Intensity < 300)

# Plot the filtered data to check what remains
plot(las_filtered, color = "Intensity")


# ========================================================
# Assignment: LiDAR Products
# ========================================================

# 1. Load the clipped LiDAR data (From the previous step)
las <- readLAS("data/lidar/lidar_2018_clipped.las")


# --------------------------------------------------------
# Part 1: DEM, DSM, and CHM (1 meter resolution)
# --------------------------------------------------------

# 1. Calculate DEM using triangular irregular network (tin) algorithm at 1m resolution
dem <- rasterize_terrain(las, res = 1, algorithm = knnidw())
# 2. Calculate DSM using pitfree algorithm at 1m resolution
dsm <- rasterize_canopy(las, res = 1, algorithm = p2r())

# 3. Calculate Canopy Height Model (CHM = DSM - DEM)
chm <- dsm - dem

# 4. Plot the three products to visually check them
plot(dem, main = "Digital Elevation Model (DEM) - 1m")
plot(dsm, main = "Digital Surface Model (DSM) - 1m")
plot(chm, main = "Canopy Height Model (CHM) - 1m")

# 5. Save the CHM as a GeoTIFF file inside the lidar subdirectory
writeRaster(chm, filename = "data/lidar/lahntal_chm_1m.tif", overwrite = TRUE)


# --------------------------------------------------------
# Part 2: Mean Vegetation Height (Sentinel-2 Alignment)
# --------------------------------------------------------

# 1. Load the first layer (Blue) of the cropped Lahntal Sentinel-2 scene from Assignment 4
s2_layer1 <- rast("data/lidar/lahntal_chm_1m.tif")[[1]]

# 2. Crop the Sentinel layer to match the exact spatial extent of the LiDAR point cloud
s2_cropped <- crop(s2_layer1, ext(las))

# 3. Calculate DEM using the Sentinel tile as a grid template (10m resolution)
dem_s2 <- rasterize_terrain(las, res = s2_cropped, algorithm = tin())

# 4. Topographic Normalization: transform absolute heights to heights above ground
las_normalized <- normalize_height(las, tin())

# 5. Calculate the Mean Vegetation Height for each pixel using the Sentinel grid template
# pixel_metrics computes statistics (mean of Z) for points falling inside each grid cell
mean_veg_height <- pixel_metrics(las_normalized, ~mean(Z), res = s2_cropped)

# 6. Plot the calculated mean vegetation height
plot(mean_veg_height, main = "Mean Vegetation Height (10m Sentinel Grid)")

# 7. Save the final product as a GeoTIFF file
writeRaster(mean_veg_height, filename = "data/lidar/lahntal_mean_veg_height.tif", overwrite = TRUE)


# --------------------------------------------------------
# Part 3: Overlay Visualization
# --------------------------------------------------------

# Plot the original Sentinel scene layer as background, and overlay the mean vegetation height
plot(s2_cropped, main = "Mean Vegetation Height Overlay on Sentinel-2")
plot(mean_veg_height, add = TRUE, col = rev(terrain.colors(10)), alpha = 0.6)