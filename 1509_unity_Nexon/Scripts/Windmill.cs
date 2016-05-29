using UnityEngine;
using System.Collections;

public class Windmill : MonoBehaviour {

	Quaternion rot;

	void Start () {
		rot = Quaternion.Euler (45, 90, 90);
	}
	
	// Update is called once per frame
	void Update () {

		rot.x += Time.deltaTime;
		transform.localRotation = rot;
	}
}
