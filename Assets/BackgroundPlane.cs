using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BackgroundPlane : MonoBehaviour {
	public Camera _camera;
	public float distance;

	// Use this for initialization
	void Start () {
		if(_camera == null){
			_camera = Camera.main;
		}
	}
	
	// Update is called once per frame
	void Update () {

		if (distance < 0)
			distance = 0;

		transform.position = _camera.transform.position + _camera.transform.rotation * Vector3.forward * distance;

		//float scale_x = Mathf.Sin(_camera.fieldOfView) * distance  * 0.6f * 0.9f;
		//_camera.
		//transform.localScale = new Vector3(scale_x, 1, 1);

		var frustumHeight = 2.0f * distance * Mathf.Tan(_camera.fieldOfView * 0.5f * Mathf.Deg2Rad);
		var frustumWidth = frustumHeight * _camera.aspect;

		transform.localScale = new Vector3(frustumWidth * 0.1f , 1, frustumHeight * 0.1f );

		//Facing camera transform
		transform.LookAt(transform.position - _camera.transform.rotation * Vector3.down, _camera.transform.rotation * Vector3.down);

	}
}
