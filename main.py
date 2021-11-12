#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec  8 15:21:43 2020

@author:

    Jack Shine

    Graduate Student Researcher

    National Aerothermochemistry and Hypersonic Labratory

    Texas A & M University
"""
# NOTE: Axis of cylindrical body must be oriented along x axis

from initialize import mesh_reader, point_cloud_writer
from excel_writer import exporter
import open3d as o3d
import os
import time
import numpy as np
import perturb

start_time = time.time()

input_path  = os.getcwd()+"/"
output_path = os.getcwd()+"/"
mesh_file   = "Discrete_Insert_1.stl"
file_name = mesh_file.split('.')[0]
folder = file_name+"_Outputs"
##############################################################################
# Alter these fourier series function parameters
N=100           # Upper limit of summation
M=100           # Upper limit of summation
lambda_k=120    # Max amplitude
##############################################################################

# If folder doesn't exit, make one to save all the files into
if not os.path.exists(folder):
    os.makedirs(folder)

# Read an .STL or .PLY mesh, pass to point cloud writer
mesh = mesh_reader(input_path, mesh_file)

#  Poisson disk sampling to create point cloud
sample_points = 100000#300000
pcd = point_cloud_writer(mesh, sample_points, file_name, folder)

# Create amplitude and phase shift matrices
print("Preparing randomized amplitudes and phases...")
A, phi = perturb.wave_prep(N, M, lambda_k)

# Perturb point cloud with clylindrical fourier series
print("Perturbing point cloud...")
pts = np.float32(np.asarray(pcd.points))
pts_perturbed, double_sum, B = perturb.fourier_series(pts, phi, A, lambda_k, sample_points, N, M)

# Clear old elements
print("Clearing old elements...")
pcd.clear()

# Replace with new perturbed elements
print("Replacing point cloud elements with perturbed points...")
pcd.points.extend(pts_perturbed)

# Write a new point cloud
print("Writing to file...")
o3d.io.write_point_cloud(folder+'/'+file_name+"_point_cloud_perturbed.xyz", pcd)

print(pcd)

# Export fourier parameters to excel file
exporter(A, phi, lambda_k, N, M, pts_perturbed, folder, file_name)

np.savetxt(folder+'/'+file_name+"_coords.csv", pts_perturbed, delimiter=",")

print("Calculations completed in %.2f seconds" % (time.time() - start_time))
