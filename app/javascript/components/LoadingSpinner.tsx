import React from 'react';
import { Spinner } from 'react-bootstrap';

const LoadingSpinner = () => (
  <div className="text-center">
    <Spinner animation="border" variant="primary" />
  </div>
);

export default LoadingSpinner;