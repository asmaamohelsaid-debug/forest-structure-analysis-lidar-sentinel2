# forest-structure-analysis-lidar-sentinel2
Large-scale geospatial data analysis project combining LiDAR and Sentinel-2 imagery to model forest structure, estimate vegetation height, and generate high-resolution terrain products using R.
**3D Forest Structural Modeling & Satellite Data Integration (LiDAR & Sentinel-2)**

**Project Overview**

Developed a geospatial analysis workflow integrating airborne LiDAR point clouds and Sentinel-2 satellite imagery to model forest structure, estimate vegetation height, and generate terrain products for the Lahntal region, Germany.

**Tools & Technologies**

R, RStudio, lidR, terra, sf, LiDAR (.LAS), Sentinel-2 Imagery, GIS & Remote Sensing.

**Data Scale**

* Processed airborne LiDAR datasets exceeding 1 GB and containing tens of millions of 3D points.
* Worked with Sentinel-2 multispectral imagery (500–800 MB scenes) at 10 m spatial resolution.
* Generated high-resolution raster products at 1 m resolution for terrain and canopy analysis.

**Key Contributions**

* Processed and optimized large-scale LiDAR datasets using spatial clipping and memory management techniques.
* Generated Digital Elevation Models (DEM) and Digital Surface Models (DSM) from airborne LiDAR data.
* Derived Canopy Height Models (CHM) to estimate vegetation height and forest structure.
* Applied topographic normalization to convert absolute elevations into heights above ground level.
* Calculated mean vegetation height and aligned LiDAR-derived metrics with Sentinel-2 satellite grids for multi-sensor analysis.
* Produced geospatial outputs in GeoTIFF format for visualization and environmental assessment.

**Results**

* Successfully integrated 3D structural information from LiDAR with multispectral satellite observations.
* Created high-resolution forest canopy and terrain products suitable for vegetation monitoring and environmental analysis.
* Improved processing efficiency for large geospatial datasets through optimized workflows and memory-aware computation.
